
/**
 * slibzip7.i
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



&if defined( xSLibZip7 ) = 0 &then

    define var zip7_lRunning as log no-undo.

    &if "{1}" = "no-error" &then
          {slib/start-slib.i "'slib/slibzip7.p'" "( 'no-error', output zip7_lRunning )"}
    &else {slib/start-slib.i "'slib/slibzip7.p'" "( ?,          output zip7_lRunning )"}
    &endif

    {slib/slibzip7frwd.i "in super"}

    {slib/slibzip7prop.i}

    &glob xSLibZip7 defined

&endif /* defined */
