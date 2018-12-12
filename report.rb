require 'csv'

students = []
marks = []
courses = []
tests = []

p students

CSV.foreach('students.csv') do |row|
  students << {:id => row[0], :name => row[1]}
end

CSV.foreach('marks.csv') do |row|
  marks << {:test_id => row[0], :student_id => row[1], :mark => row[2]}
end

p students
p marks
