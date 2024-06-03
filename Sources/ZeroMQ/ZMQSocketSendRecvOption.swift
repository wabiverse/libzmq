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

public extension ZMQ
{
  enum SocketSendRecvOption: Int32
  {
    case none
    case dontWait
    case sendMore
    case dontWaitSendMore

    /// This is a workaround to return dynamically loaded ZMQ_ constants
    public var rawValue: Int32
    {
      switch self
      {
        case .none: 0
        case .dontWait: ZMQ_DONTWAIT
        case .sendMore: ZMQ_SNDMORE
        case .dontWaitSendMore: ZMQ_DONTWAIT | ZMQ_SNDMORE
      }
    }

    public func isValidRecvOption() -> Bool
    {
      self == .none || self == .dontWait
    }
  }
}
