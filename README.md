# Supabase Open Source Ecommerce Multivendor

THIS IS A OPEN SOURCE ECOMMERCE MADE BY ME (Rodrigo), YOU CAN USE THIS FOR FREE WITHOUT RESTRICTIONS. IT IS NOT MANDATORY TO GIVE CREDITS, BUT I WOULD LIKE YOU TO DO IT BY REDIRECTING TO THIS GITHUB
Flutter Ecommerce Multivendor with the purpose of demonstrating the different functions that Supabase contains, an alternative to Firebase.

## Getting Started
This project was created to demonstrate the use of Supabase CRUD and Auth with extras for example Image Cache and Provider

In order to use this project, you must have a Supabase account and open a database (it works in the free version). If you are new you can follow the steps below to set the basic settings for the project to work

### Step 1 - Constants

In order to connect the database to the application, you must configure the Supaurl and AnonKey constants with the data indicated in the database as described in the image

### Step 2 - Create Tables on Database section

In order to store variables you need to open tables named Products and Orders with the constants that will be entered.
These variables must be the same as in the classes named OrdersStream and ProductsStream as described in the image

### Step 3 - Create Storage Bucket

A storage bucket must be created to be able to store the images of the products, later you must configure its rules to allow the addition, modification, deletion and selection of files.
The image shows that it should be product-images as it is in the application

### Optional Step 4 - Auth Providers (Google, Facebook, ETC) which is also called deep links

In order to achieve the operation of authentication providers such as google (they are not included in this project) you must provide it in the myAuthRedirectUri variable, which is already exemplified by the Supabase documentation by default, therefore you must add it to the database.

### Step 5 Enjoy :)

### DOCS

https://supabase.com/docs/guides/with-flutter
https://github.com/supabase-community/supabase-flutter
https://github.com/supabase-community/supabase-dart



I do not provide any type of support when referring to open source but in case of errors in my free time I can solve them



