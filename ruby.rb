=begin

* what is the function of modules in ruby ? 
	- The function of a modules is encapsules behaviour with diferentes elements in ruby for example with methods, classes or Constants.
	Also it provides a mechanism for multiple inheritance and the most import one is that the module it uses to reuse code.

* What is the differences between modules and class ? 
	-Modules is a block of code, with module we can not instance a module we extend it, require it. On the other hand a class is a blueprint to create objects.
  A class has differents features like attributes, instance methods, class methods and it is a important part of OOP (Object-oriented programming)

* What is the difference between extend and include ? 
include => Add the module's method as instance methods to the including class. it means that only when we instance the class to get a object we can get access to the method.
extend => Add the module's method as class methods to the including class. 

=end


module MyModule
  def instance_method
    "I am an instance method"
  end

  def class_method_ole 
    "I am an class method"
  end

  def self.class_method
    "I am a class method"
  end
end

class Person
  include MyModule  # Agrega los métodos de instancia a la clase
  extend MyModule   # Agrega los métodos de clase a la clase
end

# Método de instancia (agregado a la instancia de la clase)
person = Person.new
puts person.instance_method  # Output: "I am an instance method"


p  MyModule.class_method
p Person.class_method_ole
