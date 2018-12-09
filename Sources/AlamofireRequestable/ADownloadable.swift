//
//  Downloadable.swift
//  Restofire
//
//  Created by Rahul Katariya on 27/01/18.
//  Copyright © 2018 AarKay. All rights reserved.
//

import Foundation
import Alamofire

/// Represents a `Downloadable` for Alamofire.
///
/// ### Create custom Downloadable
/// ```swift
/// protocol HTTPBinDownloadService: ADownloadable {
///
///     var path: String? = "bytes/\(4 * 1024 * 1024)"
///     var destination: DownloadFileDestination?
///
///     init(destination: @escaping DownloadFileDestination) {
///         self.destination = destination
///     }
///
/// }
/// ```
public protocol ADownloadable: ARequestable {
    
    /// The resume data.
    var resumeData: Data? { get }
    
    /// The download file destination.
    var destination: DownloadRequest.Destination? { get }
    
    /// The Alamofire data request validation.
    var validationBlock: DownloadRequest.Validation? { get }
    
}

public extension ADownloadable {
    
    /// `nil`
    public var resumeData: Data? {
        return nil
    }
    
    /// `nil`
    public var destination: DownloadRequest.Destination? {
        return nil
    }
    
    /// `Validation.default.downloadValidation`
    public var validationBlock: DownloadRequest.Validation? {
        return validation.downloadValidation
    }

}

public extension ADownloadable {
    
    /// Creates a `DownloadRequest` to retrieve the contents of a URL based on the specified `Requestable`
    ///
    /// If `startRequestsImmediately` is `true`, the request will have `resume()` called before being returned.
    ///
    /// - returns: The created `DownloadRequest`.
    public func asRequest() throws -> DownloadRequest {
        return RestofireRequest.downloadRequest(
            fromRequestable: self,
            withUrlRequest: try asUrlRequest()
        )
    }
    
}
