//
//  LazyUtils.swift
//  LazyKit
//
//  Created by Kevin Malkic on 15/02/2016.
//  Copyright © 2016 Kevin Malkic. All rights reserved.
//

/*!
* @function lazy_main_dispatch_after
*
* @abstract
* Schedule a block for execution on a given queue at a specified time.
*
* @discussion
* Passing DISPATCH_TIME_NOW as the "when" parameter is supported, but not as
* optimal as calling dispatch_async() instead. Passing DISPATCH_TIME_FOREVER
* is undefined.
*
* @param when
* A temporal milestone returned by dispatch_time() or dispatch_walltime().
*
* @param block
* The block of code to execute.
* The result of passing NULL in this parameter is undefined.
*/
public func lazy_main_dispatch_after(_ when: TimeInterval, _ block: @escaping ()->()) {

    let delayTime = DispatchTime.now() + Double(Int64(when * TimeInterval(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
    
    DispatchQueue.main.asyncAfter(deadline: delayTime, execute: block)
}

/*!
* @function lazy_main_dispatch_async
*
* @abstract
* Submits a block for asynchronous execution on a dispatch queue.
*
* @discussion
* The dispatch_async() function is the fundamental mechanism for submitting
* blocks to a dispatch queue.
*
* Calls to dispatch_async() always return immediately after the block has
* been submitted, and never wait for the block to be invoked.
*
* The target queue determines whether the block will be invoked serially or
* concurrently with respect to other blocks submitted to that same queue.
* Serial queues are processed concurrently with respect to each other.
*
* @param block
* The block to submit to the target dispatch queue. This function performs
* Block_copy() and Block_release() on behalf of callers.
* The result of passing NULL in this parameter is undefined.
*/
public func lazy_main_dispatch_async(_ block: @escaping ()->()) {

    DispatchQueue.main.async(execute: block)
}
