# Filters (temp name)

form validation (most common fields) for later re-use, ideally without dependencies

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

# Log

26/11/2019: Refactor first name, last name, email and date fields to use inheritance for cleaner code. Used named constructors i.o. separated widgets. On the minus side: the `controller` field is now mandatory to avoid erratic cursor behavior.
*Learnings*: use of high-order functions (to allow users to still use onChanged Field), inheritance in Dart