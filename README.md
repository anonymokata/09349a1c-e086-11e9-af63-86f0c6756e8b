#Run Sample Program

#Dependencies
bundle install

#Run Tests
rspec

#--Notes on implementation design decisions--#
#Point Degradation
Cases outside uppercase, lowercase, and whitespace (e.g. special characters, etc.) were not mentioned in the prompt, so I'm assuming degrading by a point value of one for these cases is okay.

#Pencil.edit instance method
Edit will only edit text if the pencil is fully functional (i.e. neither the point nor eraser are dull).