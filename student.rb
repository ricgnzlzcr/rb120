class Student
  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(student2)
    grade > student2.grade
  end

  protected

  def grade
    @grade
  end

end

bob = Student.new("Bob", 78)
dan = Student.new("Bob", 78)
puts bob.better_grade_than?(dan)

puts bob == dan