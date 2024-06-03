/* ----------------------------------------------------------------
 * :: :  Z  E  R  O  M  Q  :                                     ::
 * ----------------------------------------------------------------
 * This software is Licensed under the terms of the Apache License,
 * version 2.0 (the "Apache License") with the following additional
 * modification; you may not use this file except within compliance
 * of the Apache License and the following modification made to it.
 * Section 6. Trademarks. is deleted and replaced with:
 *
 * Trademarks. This License does not grant permission to use any of
 * its trade names, trademarks, service marks, or the product names
 * of this Licensor or its affiliates, except as required to comply
 * with Section 4(c.) of this License, and to reproduce the content
 * of the NOTICE file.
 *
 * This software is distributed in the hope that it will be useful,
 * but WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND without even an
 * implied warranty of MERCHANTABILITY, or FITNESS FOR A PARTICULAR
 * PURPOSE. See the Apache License for more details.
 *
 * You should have received a copy for this software license of the
 * Apache License along with this program; or, if not, please write
 * to the Free Software Foundation Inc., with the following address
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
 *
 *         Copyright (C) 2024 Wabi Foundation. All Rights Reserved.
 * ----------------------------------------------------------------
 *  . x x x . o o o . x x x . : : : .    o  x  o    . : : : .
 * ---------------------------------------------------------------- */

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
