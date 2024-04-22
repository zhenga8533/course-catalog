class CourseService
  include HTTParty
  base_uri 'content.osu.edu/v2/classes/'

  def self.fetch_classes(search_params = {})
    # Initialize an empty array to store fetched courses
    courses = []

    # Merge search parameters with default parameters
    default_params = { q: 'cse', client: 'class-search-ui', campus: 'col', term: '1244', academic_career: 'ugrad', subject: 'cse', class_attribute: 'ge2' }
    query_params = default_params.merge(search_params)

    response = get('/search', query: query_params)
    
    if response.success?
      data = JSON.parse(response.body)['data']
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
          course_id: course['courseId']
        }
        new_course = Course.find_or_create_by(course_attributes)
        courses << new_course

        sections_data = course_data['sections']
        sections_data.each do |section_data|
          meeting_data = section_data['meetings'][0]
          section_attributes = {
            section_number: Integer(section_data['classNumber']),
            component: section_data['component'],
            instruction_mode: section_data['instructionMode'],
            building_description: meeting_data['buildingDescription'],
            start_time: meeting_data['startTime'],
            end_time: meeting_data['endTime'],
            start_date: section_data['startDate'],
            end_date: section_data['endDate'],
            monday: false,
            tuesday: false,
            wednesday: false,
            thursday: false,
            friday: false,
            saturday: false,
            sunday: false,
            required_graders: 1,
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
          end

          Section.create(section_attributes)
        end
      end

      { courses: courses }
    else
      puts "Error: #{response.code} - #{response.message}"
      { error: "Error: #{response.code} - #{response.message}" }
    end
  end
end
