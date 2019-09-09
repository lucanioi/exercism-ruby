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
    students.zip(plants)
  end

  def plants
    garden.split
      .map { |row| row.chars.each_slice(2).to_a }
      .transpose.map(&:flatten)
  end
end
