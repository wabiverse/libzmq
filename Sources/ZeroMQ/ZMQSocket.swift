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

import Foundation
import zmq

public extension ZMQ
{
  class Socket
  {
    public var handle: UnsafeMutableRawPointer?

    public init(context: Context, type: SocketType) throws
    {
      // Call void *zmq_socket (void *context, int type);
      let p: UnsafeMutableRawPointer? = zmq_socket(context.handle, type.rawValue)
      guard p != nil
      else
      {
        throw ZMQError.last
      }

      // Now we can assign socket handle safely
      handle = p!
    }

    deinit
    {
      do
      {
        try close()
      }
      catch
      {
        print(error)
      }
    }

    /**
        Create an outgoing connection on the current socket
     */
    public func connect(_ endpoint: String) throws
    {
      let result = zmq_connect(handle, endpoint)
      if result == -1
      {
        throw ZMQError.last
      }
    }

    /**
        Closes the current socket
     */
    public func close() throws
    {
      let result = zmq_close(handle)
      if result == -1
      {
        throw ZMQError.last
      }
    }

    /**
        Accept incoming connections on the current socket
     */
    public func bind(_ endpoint: String) throws
    {
      let result = zmq_bind(handle, endpoint)
      if result == -1
      {
        throw ZMQError.last
      }
    }

    /**
        Stop accepting connections on the current socket
     */
    public func unbind(_ endpoint: String) throws
    {
      let result = zmq_unbind(handle, endpoint)
      if result == -1
      {
        throw ZMQError.last
      }
    }

    /**
        Send a message part via the current socket
     */
    public func send(
      string: String,
      options: SocketSendRecvOption = .none
    ) throws
    {
      let result = zmq_send(handle, string, string.count,
                            options.rawValue)
      if result == -1
      {
        throw ZMQError.last
      }
    }

    /**
        Receive a message part from the current socket
     */
    public func recv(
      bufferLength: Int = 256,
      options: SocketSendRecvOption = .none
    ) throws -> String?
    {
      // Validate allowed options
      guard options.isValidRecvOption()
      else
      {
        throw ZMQError.invalidOption
      }

      // Read n bytes from socket into buffer
      let buffer = UnsafeMutablePointer<CChar>.allocate(capacity: bufferLength)
      let bufferSize = zmq_recv(handle, buffer, bufferLength,
                                options.rawValue)
      if bufferSize == -1
      {
        throw ZMQError.last
      }

      // Limit string buffer to actual buffer size
      let data = Data(bytes: buffer, count: Int(bufferSize))

      // Return read UTF8 string
      return String(data: data, encoding: String.Encoding.utf8)
    }
  }
}
