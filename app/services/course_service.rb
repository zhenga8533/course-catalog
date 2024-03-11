require 'httparty'
require 'pagy'

class CourseService
  include HTTParty
  base_uri 'contenttest.osu.edu/v2/classes/'

  def self.fetch_classes(search_params = {})
    Course.delete_all
    Section.delete_all

    # Merge search parameters with default parameters
    default_params = { q: 'cse', client: 'class-search-ui', campus: 'col', term: '1244', academic_career: 'ugrad', subject: 'cse', class_attribute: 'ge2' }
    query_params = default_params.merge(search_params)

    response = get('/search', query: query_params)
    
    if response.success?
      data = JSON.parse(response.body)['data']
      total_items = data['totalItems'] || 0

      courses_data = data['courses']
      courses_data.each do |course_data|
        course = course_data['course']
        course_attributes = {
          term: course['term'],
          title: course['title'],
          description: course['description'],
          subject: course['subject'],
          catalog_number: course['catalogNumber'],
          campus: course['campus'],
          course_id: course['courseId'],
        }
        new_course = Course.create(course_attributes)

        sections_data = course_data['sections']
        sections_data.each do |section_data|
          section_attributes = {
            section_number: section_data['classNumber'],
            component: section_data['component'],
            instruction_mode: section_data['instructionMode'],
            building_description: '',
            start_time: '',
            end_time: '',
            start_date: section_data['startDate'],
            end_date: section_data['endDate'],
            monday: false,
            tuesday: false,
            wednesday: false,
            thursday: false,
            friday: false,
            saturday: false,
            sunday: false,
            course_id: new_course.id
          }

          # Loop through meetings to get section schedule
          section_data['meetings'].each do |section_meeting|
            section_attributes['monday'] ||= section_meeting['monday']
            section_attributes['tuesday'] ||= section_meeting['tuesday']
            section_attributes['wednesday'] ||= section_meeting['wednesday']
            section_attributes['thursday'] ||= section_meeting['thursday']
            section_attributes['friday'] ||= section_meeting['friday']
            section_attributes['saturday'] ||= section_meeting['saturday']
            section_attributes['sunday'] ||= section_meeting['sunday']
            section_attributes['building_description'] = section_meeting['buildingDescription']
            section_attributes['start_time'] = section_meeting['startTime']
            section_attributes['end_time'] = section_meeting['endTime']
          end

          Section.create(section_attributes)
        end
      end
    else
      puts "Error: #{response.code} - #{response.message}"
      return { error: "Error: #{response.code} - #{response.message}" }
    end
    
    pagy = Pagy.new(count: total_items, page: response.headers['X-Page'] || 1, items: response.headers['X-Per-Page'] || Pagy::DEFAULT[:items_per_page])
    courses = Course.all.offset(pagy.offset).limit(pagy.items)

    { courses: courses, pagy: pagy }
  end
end