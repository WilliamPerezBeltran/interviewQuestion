# ruby-test
https://adrianmejia.com/ruby-on-rails-architectural-design/
https://adrianmejia.com/ruby-on-rails-architectural-design/
https://adrianmejia.com/ruby-on-rails-architectural-design/
https://adrianmejia.com/ruby-on-rails-architectural-design/
https://adrianmejia.com/ruby-on-rails-architectural-design/
https://adrianmejia.com/ruby-on-rails-architectural-design/
https://runebook.dev/es/docs/rails/guides/action_controller_overview
https://runebook.dev/es/docs/rails/guides/action_controller_overview
Test in ruby 

## Stack
- ruby 2.6.3p62

## Questions

1. How do you calculate the power of a number?
	- In the code it is located in the folder "powerNumber"
2. Write a ruby method that returns the even numbers from an array of float numbers. (Do not use the even ruby method)
	- In the code it is located in the folder "evenNumbers"

3. What are collection and member routes?

    They are route specifications in rails, a member route is one that must specify an Id,
    example:
  - this path member {get 'preview'} generates this path: preview_data_path (@data) => url: / datas / 1 / preview

  and a collection path will generate a collection of objects.
  example:
  - collection {get 'search'} will generate: search_photos_path that represents this url / photos / search

4. What is polymorphism?

    It is one of the characteristics of object-oriented programming that allows flexibility.
    Polymorphism occurs when classes are related to each other through inheritance. Therefore by means of the
    inheritance the attributes and methods of the class are inherited and in polymorphism these methods are used to generate different tasks, that is,
    polymorphism allows us to use a simple action in different ways during the execution of the program, hence its name "polymorphism" which means many ways.

5.  What is the purpose of object private methods?
    The main objective of the private methods is to protect the sensitive data of the application. That is why elements that are declared as private are only accessible within the scope of the class in which it is declared.

6.   Write a web scraper that will generate a csv of all the 3 bedroom, 2 bathroom homes for rent     in a given city on Craigslist. The csv should have the following columns: title, address (if     available), monthly rent (if available), URL

    note: Web scraping is downloading information from a web page through spiders, therefore if the URL to which web scraping is going to be done is not specified, it is impossible to do web scraping.

### Note

By definition in maths an even number is an **integer** that is divisible by two. That means that a decimal is neither even nor odd. By principle of parity it is only possible for number **integers**. This is regarding the second point.

### Clone repo

```bash
# Clone repo
$ https://github.com/WilliamPerezBeltran/ruby-test.git

# Go to app directory
$ cd ruby-test
```

## Execute code
```bash
# Clone repo
$ https://github.com/WilliamPerezBeltran/ruby-test.git

# Go to app directory
$ cd ruby-test
```



### Run code
#### "evenNumbers"

```bash
# Go into folder
$ cd evenNumbers/

# Execute code
$ ruby main.rb

# Type data in terminal 
$ [1.5,5.2,5.0,6.2,12.3,15.0,25.0,25.4,25.0,3.5,2.6,2.0,8.0] 

```

### Run code
#### "powerNumber"

```bash
# Go into folder
$ cd powerNumber/

# Execute code
$ ruby main.rb

# Example
# Type base number 
$ 2

# Type exponent number 
$ 3
```

## Creators

**William Pérez**

- <https://github.com/WilliamPerezBeltran>
