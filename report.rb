require 'csv'
require 'json'
require "awesome_print"


students_array = []
marks_array = []
courses_array = []
tests_array = []

puts "path of students file?"
filename = gets.chomp
students = CSV.read(filename)[1 .. -1]

puts "Path of marks file?"
filename = gets.chomp
marks = CSV.read(filename)[1 .. -1]

puts "Path of courses file?"
filename = gets.chomp
courses = CSV.read(filename)[1 .. -1]

puts "Path of tests file?"
filename = gets.chomp
tests = CSV.read(filename)[1 .. -1]

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
  total_average = (student_marks.sum.to_f / total_weight.to_f)
  return total_average.round(2)
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
    grade = (student_marks.sum.to_f / total_weight.to_f)
    return grade.round(2)
  else
    return grade.round(2)
  end
end


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
