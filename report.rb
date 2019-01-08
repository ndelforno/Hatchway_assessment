require 'csv'
require 'json'

students_array = []
marks_array = []
courses_array = []
tests_array = []



students = CSV.read('students.csv')[1 .. -1]
marks = CSV.read('marks.csv')[1 .. -1]
courses = CSV.read('courses.csv')[1 .. -1]
tests = CSV.read('tests.csv')[1 .. -1]



students.each do |student|
  students_array << {:id => student[0], :name => student[1]}
end


marks.each do |mark|
  marks_array << {:test_id => mark[0], :student_id => mark[1], :mark => mark[2]}
end

courses.each do |course|
  courses_array << {:id => course[0], :name => course[1], :teacher => course[2]}
end

tests.each do |test|
  tests_array << {:id => test[0], :course_id => test[1], :weight => test[2]}
end





p students_array
puts '---------'
p marks_array
puts '---------'
p courses_array
puts '---------'
p tests_array

students_array.each do |student|

  print "student Id: #{student[:id]}, name: #{student[:name]}\n"
  print "total Average: \n"

  courses_array.each do |course|
    print "Course: #{course[:name]}, Teacher: #{course[:teacher]}\n"
  end
  puts "--------"
end
