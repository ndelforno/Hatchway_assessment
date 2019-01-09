require 'csv'
require 'json'
require "awesome_print"


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



# myhash = {
#   :students => students_array,
#   :marks => marks_array,
#   :courses => courses_array,
#   :tests => tests_array
# }
# p myhash
#
# p students_array
# puts '---------'
# p marks_array
# # puts '---------'
# # p courses_array
# puts '---------'
# p tests_array

def total_student_average(student_id,marks_array, tests_array)
  total_weight = 0
  total_average = 0
  student_marks = []
  marks_array.each do |mark|
    tests_array.each do |test|
      if test[:id] == mark[:test_id] && mark[:student_id] == student_id.to_s
          total_weight += test[:weight].to_i
          student_marks << mark[:mark].to_i * test[:weight].to_i
      end
    end
  end
  total_average = (student_marks.sum / total_weight)
  return total_average
end

def find_grade(course_id, student_id, marks_array, tests_array)
  total_weight = 0
  grade = 0
  student_marks = []
  marks_array.each do |mark|
    tests_array.each do |test|
      if test[:id] == mark[:test_id] && mark[:student_id] == student_id.to_s && test[:course_id] == course_id
        total_weight += test[:weight].to_i
        student_marks << mark[:mark].to_i * test[:weight].to_i
      end
    end
  end
  if total_weight != 0
    grade = (student_marks.sum / total_weight)
    return grade
  else
    return grade
  end
end


# p total_student_marks(1, marks_array, tests_array)

students_array.each do |student|
  total_average = total_student_average(student[:id], marks_array, tests_array)
  print "student Id: #{student[:id]}, name: #{student[:name]}\n"
  print "total Average:     #{total_average} % \n"

  courses_array.each do |course|
    final_grade = find_grade(course[:id],student[:id], marks_array, tests_array)
    print "          Course: #{course[:name]}, Teacher: #{course[:teacher]}\n"
    print "          Final Grade: #{final_grade} %\n"
  end
  puts "--------"
end
