
/**
 * slibwebfrwd.i -
 *
 * (c) Copyright ABC Alon Blich Consulting Tech, Ltd.
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program. If not, see <http://www.gnu.org/licenses/>.
 *
 *  Contact information
 *  Email: alonblich@gmail.com
 *  Phone: +263-77-7600818
 */



function web_setUserId          returns log     ( pcUserId as char, pcPassword as char ) {1}.

function web_getProgramField    returns char    ( pcFieldName as char ) {1}.
function web_setProgramField    returns log     ( pcFieldName as char, pcFieldValue as char ) {1}.
function web_getSessionField    returns char    ( pcFieldName as char ) {1}.
function web_setSessionField    returns log     ( pcFieldName as char, pcFieldValue as char ) {1}.
