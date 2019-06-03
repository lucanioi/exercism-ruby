class School
  def initialize
    @students = Hash.new { |h, k| h[k] = [] }
  end

  def students(grade)
    @students[grade]
  end

  def add(student, grade)
    @students[grade].push(student).sort!
  end

  def students_by_grade
    @students.sort.map do |grade, students|
      {grade: grade, students: students.dup}
    end
  end
end
