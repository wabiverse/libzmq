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
  enum SocketType: Int32
  {
    // Request-reply pattern
    case request
    case reply
    case router
    case dealer

    // Publish-subscribe pattern
    case publish
    case subscribe
    case xpublish
    case xsubscribe

    // Pipeline pattern
    case push
    case pull

    /// Exclusive pair pattern
    case pair

    /// Native pattern
    case stream

    /// This is a workaround to return dynamically loaded ZMQ_ constants
    public var rawValue: Int32
    {
      switch self
      {
        // Request-reply pattern
        case .request: ZMQ_REQ
        case .reply: ZMQ_REP
        case .router: ZMQ_ROUTER
        case .dealer: ZMQ_DEALER

        // Publish-subscribe pattern
        case .publish: ZMQ_PUB
        case .subscribe: ZMQ_SUB
        case .xpublish: ZMQ_XPUB
        case .xsubscribe: ZMQ_XSUB

        // Pipeline pattern
        case .push: ZMQ_PUSH
        case .pull: ZMQ_PULL

        // Exclusive pair pattern
        case .pair: ZMQ_PAIR

        // Native pattern
        case .stream: ZMQ_STREAM
      }
    }
  }
}
