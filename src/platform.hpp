/* SPDX-License-Identifier: MPL-2.0 */

#ifndef __ZMQ_PLATFORM_HPP_INCLUDED__
#define __ZMQ_PLATFORM_HPP_INCLUDED__

//  This file provides the configuration for Linux, Windows, and OS/X
//  as determined by ZMQ_HAVE_XXX macros passed from project.gyp

//  Set for all platforms
#define ZMQ_USE_LIBSODIUM 1
#define ZMQ_HAVE_CURVE 1
#define ZMQ_IOTHREAD_POLLER_USE_POLL 1
#define ZMQ_CACHELINE_SIZE 64
#define ZMQ_POLL_BASED_ON_POLL 1
#define ZMQ_HAVE_WS 1
#define ZMQ_HAVE_STRLCPY 1
#define ZMQ_USE_GNUTLS 1
#define ZMQ_USE_CV_IMPL_PTHREADS 1
#define HAVE_STRNLEN 1

#if defined(_WIN32)
#   define ZMQ_USE_SELECT 1

#elif defined(__APPLE__)
#   define ZMQ_USE_KQUEUE 1
#   define HAVE_POSIX_MEMALIGN 1
#   define ZMQ_HAVE_IFADDRS 1
#   define ZMQ_HAVE_SO_KEEPALIVE 1
#   define ZMQ_HAVE_TCP_KEEPALIVE 1
#   define ZMQ_HAVE_TCP_KEEPCNT 1
#   define ZMQ_HAVE_TCP_KEEPINTVL 1
#   define ZMQ_HAVE_UIO 1
#   define HAVE_FORK 1

#elif defined(__linux__)
#   define ZMQ_USE_EPOLL 1
#   define HAVE_POSIX_MEMALIGN 1
#   define ZMQ_HAVE_EVENTFD 1
#   define ZMQ_HAVE_IFADDRS 1
#   define ZMQ_HAVE_SOCK_CLOEXEC 1
#   define ZMQ_HAVE_SO_BINDTODEVICE 1
#   define ZMQ_HAVE_SO_KEEPALIVE 1
#   define ZMQ_HAVE_SO_PEERCRED 1
#   define ZMQ_HAVE_TCP_KEEPCNT 1
#   define ZMQ_HAVE_TCP_KEEPIDLE 1
#   define ZMQ_HAVE_TCP_KEEPINTVL 1
#   define ZMQ_HAVE_UIO 1
#   define HAVE_CLOCK_GETTIME 1
#   define HAVE_FORK 1
#   define HAVE_ACCEPT4 1

#else
#   error "No platform defined, abandoning"
#endif

#endif
