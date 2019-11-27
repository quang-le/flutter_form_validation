# Filters (temp name)

Form validation (most common fields) for later re-use, ideally without dependencies.
The objective is to create ready-to-use widgets for common fields like date, name, email etc. so I don't have to worry about it later, and to learn a thing or two in the process.
Once the project is done, I'll probably re-organize it as a package.

## credits
regexp for email format validation taken from [validators package](https://pub.dev/packages/validators)

## Targeted features

[X] date input format

[X] date input conversion to DateTime

[X] html chars sanitizing

[X] email format validation

[X] First name format 

[X] First name validation

[X] Last name format
 
[X] Last name validation

[] phone number format

[] phone number validation (national standards)

[] country format

[] country validation

[] zip code format

[] zip code validation

[] address code format

[] address code validation

# known bugs 

[X] custom input formatters cause cursor to remain at start of text

[X] Refactor has broken cursor positioning

#Current features

Everything is implemented in a class called `Field` which extends `TextFormField`. There is a named constructor for each specific field (e.g.: `Field.email`). 
Each constructor provides a default value for `inputFormatter` and `validator`. Apart from that, `Field` can be used just like `TextFormField`.
The default `validator` can be overriden by giving the `validator` field a value.
The default `inputFormatters` can be overridden the same way.
To use the default `inputFormatters` but with custom error messages, use the ad-hoc custom validator function, e.g:
``  validator: Validate.customDateValidator('eur',
                dateErrorMsg: 'custom error message',
                dateNotInRangeErrorMsg: 'custom msg date not in range'),
          ),`` 
          
 `onChanged` should behave normally, but I use it to manage the cursor position, so any user-defined function is wrapped in another function that executes the cursor managing function after it.


# Log

26/11/2019: Refactor first name, last name, email and date fields to use inheritance for cleaner code. Used named constructors i.o. separated widgets. On the minus side: the `controller` field is now mandatory to avoid erratic cursor behavior.
*Learnings*: use of high-order functions (to allow users to still use onChanged Field), inheritance in Dart