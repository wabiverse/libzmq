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
