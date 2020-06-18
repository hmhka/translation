
About the structure definition includefiles....

Many API functions have a STRUCTURE parameter, which is actually 
a pointer to a structure. In Progress you can use a MEMPTR variable 
and set the values for its members using PUT-LONG statements.

I was getting bored by having to use PUT-LONG() and having
to count offsets for every single datamember in a MEMPTR variable
so I have tried to encapsulate it in group of lower-level
include files.

It appeared that only a record buffer would allow a syntax like 
   rectangle.top  = 50
   rectangle.left = 130 

It is not difficult to define a record buffer (using a temp-table
with just a single record) with fields similar to a structure.
But: a record buffer can not be used in an API call.
So I needed procedures for transfering the contents of a record
buffer to a memptr variable, and vice versa.

File {win32/struct/rect.i} is the easiest example: it defines a
memptr variable (named lpRect) and a temp-table (also named
lpRect). Procedure buf2mem_lpRect transfers the contents of the
temp-table record into the memptr. Procedure mem2buf_lpRect
transfers the contents of the memptr variable into the record.
Procedure Release_lpRect has to be called to free memory.

If a calling procedure needs a RECT structure it can just include
{win32/struct/rect.i} and it will create the default lpRect. If a
calling procedure needs more than one rectangle structure, it can
use the includefile several times by specifying the variable
name, for example:
  {win32/struct/rect &Variable="lpWindowRect"}
  {win32/struct/rect &Variable="lpClientRect"}
  {win32/struct/rect &Variable="lpDesktopRect"}

File {win32/struct/docinfo.i} is slightly more complicated
because the DOCINFO structure has string members: these members
contain pointers to strings. Solved it by using
{win32/struct/string.i} but this involves some extra r-code
overhead.

File {win32/struct/openfilename.i} is yet more complicated
because it not only has all the characteristics of docinfo.i, but
this time I have also added a couple of validations and transformations.
It may improve the overall quality, but it certainly is a lot
of overhead.

Now, what to think of includefiles like these? Are they worth the
effort? Is it easy enough to define them? Yeah, perhaps if one
can create a source generator to create these includefile...
Or is there an easier way to simplify memptr structures?
Please let me know what you think.

Regards,
   Jurjen Dijkstra
   jurjen@global-shared.com



