class Garden
  STUDENTS = %w[
    Alice Bob Charlie David Eve Fred
    Ginny Harriet Ileana Joseph Kincaid Larry
  ].freeze

  PLANTS = {
    G: :grass,
    C: :clover,
    V: :violets,
    R: :radishes
  }.freeze

  def initialize(garden, students = STUDENTS)
    @garden   = garden
    @students = students.sort
    create_student_methods
  end

  private

  attr_reader :garden, :students

  def create_student_methods
    students_and_plants.each do |student, plants|
      define_singleton_method(student.downcase) do
        plants.map { |plant| PLANTS[plant.to_sym] }
      end
    end
  end

  def students_and_plants
    plants = garden.split.map do |garden_row|
      garden_row.chars.each_slice(2).to_a
    end.transpose.map(&:flatten)

    students.zip(plants).to_h
  end
end