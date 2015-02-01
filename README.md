REQUIREMENTS

Provide a RESTful web service with equivalent functionality as the Wardrobe Management web application with GUI.

IMPLEMENTATION

The implemented Wardrobe Management API web service is a Catalyst application built in the following environment:

Ubuntu 14.04, x86_64
Perl v5.18.2
Catalyst 5.09
MySQ: 5.5

The application requires a couple of less usual Perl modules like:

    Catalyst::Controller::REST
    Lingua::EN::Inflect
    Text::CSV::Auto

Required modules are listed in Makefile.PL and will be installed by running 
    perl Makefile.PL

INSTALLATION

Apart from the provided tarball, I can put, for the ease of inspecting the code and installing, the codebase on github under 
some unconspicuous name like test_repo with an uninteresting README content, if preferred.

Codebase:

    From tarball:
        unpack the tarball: tar zxvf wardrobe_manager_api.tar.gz

    From github (if available):
        git clone git://github.com/tamarakaufler/wardrobe_manager_api.git

MySQL

    cd sql (on the same level as the README file)
    mysql -u root -p wardrobemanagerapi_user.sql
    mysql -u root -p wardrobemanagerapi.sql

    To import the provided test data, if desired:
        mysql -u root -p import_data.sql

PROVIDED FUNCTIONALITY

The application does not, currently, provide all the required functionality, and there is scope for improvement in what is provided.

1) CRud for clothing/category/outfit ... search (by id and name) and creation so far
                                                currently search by only full name, no fuzzy search 
2) Retrieval of a list of clothes, their categories and associated outfits
3) Tagging of clothes(clothing_outfit)
4) clothing and categories can be created by uploading a CSV or JSON file. Format of the JSON file can be a hash or an array of hashes.

DESIGN

I took advantage of the boilerplate code offered by Catalyst and its RESTful controller. There are two RESTful controllers: Api and Tag,
and one library module with helper functions.

CRud implementation is done through DBIC introspection, so the same code can be used for all entity types (clothing/category etc).
Retrieval of the clothings list uses a convenience Result Clothing instance method. 

The application supports upload of CSV and JSON files (curl -F option) and json content type for curl -d/--data/-T options.  

API calls:

sample upload files are in sample_files dir on the same lever as the README file

GET:

POST:
1) CRud for clothing/category/outfit ... search (by id and name) and creation so far
    curl -X GET  http://localhost:3010/api/clothing/id/3
    curl -X GET  http://localhost:3010/api/clothing/outfit/3
    curl -X GET  http://localhost:3010/api/clothing/name/iRun%20White%20Trainers
    curl -X GET  http://localhost:3010/api/category/name/Shoes
    curl -X GET  http://localhost:3010/api/outfit/id/3
    curl -X GET  http://localhost:3010/api/outfit

    curl -H "Accept: application/json" -H "Content-type: application/json" -X POST -d '{"name":"Trousers"}'  http://localhost:3010/api/category
    curl -X POST -T tagging2.json  http://localhost:3010/tag/clothing

2) Retrieval of a list of clothes, their categories and associated outfits
    curl -X GET  http://localhost:3010/api

3) Tagging of clothes(clothing_outfit)
    curl -X POST -T tagging2.json  http://localhost:3010/tag/clothing 
    curl -H "Accept: application/json" -H "Content-type: application/json" -X POST -d '{"clothing":"3", "outfit":"4"}'  http://localhost:3010/tag/clothing

4) clothing and categories can be created by uploading a CSV or JSON file. Format of the JSON file can be a hash or an array of hashes.

    the file extension should correspond to its content:        

        curl -X POST -F 'file=@clothing.csv'  http://localhost:3010/api/clothing
                                        or
        curl -X POST -F 'file=@clothing.csv'  http://localhost:3010/api/category
                                        or
        curl -X POST -F 'file=@clothing.json'  http://localhost:3010/api/clothing
                                        or
        curl -X POST -F 'file=@clothing.json'  http://localhost:3010/api/category

        curl -X POST -F 'file=@incorrect_format.js'  http://localhost:3010/api/clothing
        curl -X POST -F 'file=@empty.csv'  http://localhost:3010/api/clothing


LIMITATIONS

1) No fuzzy search
2) No unit tests
3) Limited documentation

IMPROVEMENTS 

1) Add fuzzy search
2) Add crUD functionality (update/delete)
3) When creating new entities, use find and create separately rather than find_or_create and output only created entities
4) Write unit tests
5) Add authentication/authorization
6) Add caching to improve performace
7) Add more POD
8) Add versioning
9) Could have used Try::Tiny

