
/**
 * CreateWrite.p
 *
 * By Alon Blich
 */

{libsfdc.i}

{libxml.i}

{liberr.i}

{CreateDS.i}



define input    param dataset for dsCreate.
define input    param phSObject as handle no-undo.
define output   param pcCreate  as longchar no-undo.

define var hDoc         as handle no-undo.
define var hRoot        as handle no-undo.
define var hSObjects    as handle no-undo.

define var qhSObject    as handle no-undo.
define var bhSObject    as handle no-undo.



create widget-pool.

create x-document hDoc.
create x-noderef hRoot.
create x-noderef hSobjects.

find first ttCreate no-error.
if not avail ttCreate then return.

hDoc:create-node-namespace( hRoot, {&sfdc_xNsSForce}, "sfdc:create", "element" ).
hDoc:append-child( hRoot ).

hRoot:set-attribute( "xmlns:xsi",   {&xml_xNsXsi} ).
hRoot:set-attribute( "xmlns:sfdc",  {&sfdc_xNsSForce} ).
hRoot:set-attribute( "xmlns:sfo",   {&sfdc_xNsSObject} ).



create query qhSObject.
create buffer bhSObject

    for table phSObject:get-buffer-handle(1):table-handle
        buffer-name "bSObject".

qhSObject:set-buffers( bhSObject ) no-error.
qhSObject:query-prepare( "for each bSObject" ) no-error.
qhSObject:query-open( ) no-error.

repeat while qhSObject:get-next( ):

    hDoc:create-node-namespace( hSObjects, {&sfdc_xNsSForce}, "sfdc:sObjects", "element" ).
    hRoot:append-child( hSObjects ).

    hSObjects:set-attribute( "xsi:type", "sfo:" + ttCreate.tsObjectType ).
    run sfdc_writeDSBuffer( bhSObject, hSObjects ).

end. /* repeat */

qhSObject:query-close( ) no-error.

hDoc:save( "longchar", pcCreate ).
