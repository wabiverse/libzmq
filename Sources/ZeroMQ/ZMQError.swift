/* --------------------------------------------------------------
 * :: :  L  I  B  Z  M  Q  :                                   ::
 * --------------------------------------------------------------
 * @wabistudios :: networking :: zmq
 *
 * This program is free software; you can redistribute it, and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. Check out
 * the GNU General Public License for more details.
 *
 * You should have received a copy for this software license, the
 * GNU General Public License along with this program; or, if not
 * write to the Free Software Foundation, Inc., to the address of
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
 *
 *                            Copyright (C) 2023 Wabi Foundation.
 *                                           All Rights Reserved.
 * --------------------------------------------------------------
 *  . x x x . o o o . x x x . : : : .    o  x  o    . : : : .
 * -------------------------------------------------------------- */

import zmq

/**
 * This provides a clean way to get the ZMQ library errors. This is usually
 * thrown when a -1 result is returned from a LibZMQ library function
 */
public struct ZMQError: Error, CustomStringConvertible
{
  public let description: String

  /**
   * Returns the last ZMQ library error with a string error description
   */
  public static var last: ZMQError
  {
    let errorCString = zmq_strerror(zmq_errno())!
    let description = String(validatingUTF8: errorCString)!
    return ZMQError(description: description)
  }

  public static var invalidOption: ZMQError
  {
    ZMQError(description: "Invalid option")
  }
}
