//
//  ProductListModel.swift
//  Yappetizer
//
//  Created by Harish Garg on 18/06/24.
//
import Foundation

class PawStorageManager: NSObject {
    
    // MARK: - Shared Instance
    static let shared : PawStorageManager = {
        let instance = PawStorageManager()
        return instance
    }()
    
    private override init() {}
}

// MARK: - CUSTOM FUNCTIONS
extension PawStorageManager {
    
    /// Returns URL constructed from specified directory
    fileprivate func getURL(for directory: Directory) -> URL {
        var searchPathDirectory: FileManager.SearchPathDirectory
        
        switch directory {
        case .documents:
            searchPathDirectory = .documentDirectory
        case .caches:
            searchPathDirectory = .cachesDirectory
        }
        
        if let url = FileManager.default.urls(for: searchPathDirectory, in: .userDomainMask).first {
            return url
        } else {
            fatalError("Could not create URL for specified directory!")
        }
    }
    
    /// Store an encodable struct to the specified directory on disk
    ///
    /// - Parameters:
    ///   - object: the encodable struct to store
    ///   - directory: where to store the struct
    ///   - fileName: what to name the file where the struct data will be stored
    func store<T: Encodable>(_ object: T, to directory: Directory, as fileName: PawStorageFile) {
        let filePath = "\(fileName.rawValue)_\(UserDefaultsManager.userID ?? 0)"
        let file = "\(filePath).\(fileName.fileExtension.rawValue)"
        let url = getURL(for: directory).appendingPathComponent(file, isDirectory: false)
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            print(url.absoluteString)
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        } catch {
            print(error.localizedDescription)
        }
    }
    /// Retrieve and convert a struct from a file on disk
    ///
    /// - Parameters:
    ///   - fileName: name of the file where struct data is stored
    ///   - directory: directory where struct data is stored
    ///   - type: struct type (i.e. Message.self)
    /// - Returns: decoded struct model(s) of data
    func retrieve<T: Decodable>(_ fileName: PawStorageFile, from directory: Directory, as type: T.Type) -> T? {
        let filePath = "\(fileName.rawValue)_\(UserDefaultsManager.userID ?? 0)"
        let file = "\(filePath).\(fileName.fileExtension.rawValue)"
        let url = getURL(for: directory).appendingPathComponent(file, isDirectory: false)
        print(url.absoluteString)
        if !FileManager.default.fileExists(atPath: url.path) {
            print("File at path \(url.path) does not exist!")
            return nil
        }
        
        if let data = FileManager.default.contents(atPath: url.path) {
            let decoder = JSONDecoder()
            do {
                let model = try decoder.decode(type, from: data)
                return model
            } catch {
                print(error.localizedDescription)
                return nil
            }
        } else {
            print("No data at \(url.path)!")
            return nil
        }
    }
    
    /// Retrieve and convert a struct from a file on disk
    ///
    /// - Parameters:
    ///   - file: name of the file where struct data is stored
    ///   - directory: directory where struct data is stored
    ///   - type: struct type (i.e. Message.self)
    /// - Returns: decoded struct model(s) of data, fileData and URL
    func retrieveFileData<T: Decodable>(_ fileName: PawStorageFile, from directory: Directory, as type: T.Type) -> (model: T?, fileData: Data?, fileURL: URL?) {
        let filePath = "\(fileName.rawValue)_\(UserDefaultsManager.userID ?? 0)"
        let file = "\(filePath).\(fileName.fileExtension.rawValue)"
        let url = getURL(for: directory).appendingPathComponent(file, isDirectory: false)
        print(url.absoluteString)
        if !FileManager.default.fileExists(atPath: url.path) {
            print("File at path \(url.path) does not exist!")
            return (model: nil, fileData: nil, fileURL: nil)
        }
        if let data = FileManager.default.contents(atPath: url.path) {
            let decoder = JSONDecoder()
            do {
                let model = try decoder.decode(type, from: data)
                return (model: model, fileData: data, fileURL: url)
            } catch {
                print(error.localizedDescription)
                return (model: nil, fileData: nil, fileURL: nil)
            }
        } else {
            print("No data at \(url.path)!")
            return (model: nil, fileData: nil, fileURL: nil)
        }
    }
    
    /// Remove all files at specified directory
    func clear(_ directory: Directory) {
        let url = getURL(for: directory)
        do {
            let contents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [])
            for fileUrl in contents {
                try FileManager.default.removeItem(at: fileUrl)
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    /// Remove specified file from specified directory
    func remove(_ fileName: PawStorageFile, from directory: Directory) {
        let filePath = "\(fileName.rawValue)_\(UserDefaultsManager.userID ?? 0)"
        let file = "\(filePath).\(fileName.fileExtension.rawValue)"
        let url = getURL(for: directory).appendingPathComponent(file, isDirectory: false)
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.removeItem(at: url)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    /// Returns BOOL indicating whether file exists at specified directory with specified file name
    func fileExists(_ fileName: PawStorageFile, in directory: Directory) -> Bool {
        let filePath = "\(fileName.rawValue)_\(UserDefaultsManager.userID ?? 0)"
        let file = "\(filePath).\(fileName.fileExtension.rawValue)"
        let url = getURL(for: directory).appendingPathComponent(file, isDirectory: false)
        return FileManager.default.fileExists(atPath: url.path)
    }
    
//    /// Remove specified file from specified directory
//    func removeAllFileWithPrefix(_ fileName: BallerStorageFile, in directory: Directory) {
//        let fileURLs: [URL] = retrieveFilesWithPrefix(fileName, in: directory)
//        fileURLs.forEach { url in
//            if url.lastPathComponent.contains(fileName.prefix) {
//                if FileManager.default.fileExists(atPath: url.path) {
//                    do {
//                        try FileManager.default.removeItem(at: url)
//                    } catch {
//                        fatalError(error.localizedDescription)
//                    }
//                }
//            }
//        }
//    }
//    
//    /// Retrieve All specified file from specified directory with prefix
//    func retrieveFilesWithPrefix(_ fileName: BallerStorageFile, in directory: Directory) -> [URL] {
//        let fileManager = FileManager.default
//        let documentsURL = getURL(for: directory)
//        do {
//            let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: [URLResourceKey.creationDateKey])
//            let filteredFiles = fileURLs.filter{ return $0.lastPathComponent.contains(fileName.prefix) }
//            return filteredFiles.sorted {
//                let date1 = try? $0.url?.resourceValues(forKeys: [.creationDateKey]).creationDate ?? Date()
//                let date2 = try? $1.url?.resourceValues(forKeys: [.creationDateKey]).creationDate
//                return (date1 ?? Date()) > (date2 ?? Date()) }
//        } catch {
//            print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
//            return []
//        }
//    }
        
    /// Returns BOOL indicating whether file exists at specified directory with specified file name
    func fileExists(_ fileURL: URL) -> Bool {
        return FileManager.default.fileExists(atPath: fileURL.path)
    }
    
    /// Retrieve and convert a struct from a file on disk
    ///
    /// - Parameters:
    ///   - fileURL: url of the file where struct data is stored
    /// - Returns: decoded struct model(s) of data
    func retrieve<T: Decodable>(_ fileURL: URL, as type: T.Type) -> T? {
        let url = fileURL
        print(url.absoluteString)
        if !FileManager.default.fileExists(atPath: url.path) {
            print("File at path \(url.path) does not exist!")
            return nil
        }
        if let data = FileManager.default.contents(atPath: url.path) {
            let decoder = JSONDecoder()
            do {
                let model = try decoder.decode(type, from: data)
                return model
            } catch {
                print(error.localizedDescription)
                return nil
            }
        } else {
            print("No data at \(url.path)!")
            return nil
        }
    }
    
    /// Remove specified file from specified directory
    func remove(_ fileURL: URL) {
        let url = fileURL
        print(url.absoluteString)
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.removeItem(at: url)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
}

// MARK: - Storage File Names
extension PawStorageManager {
    
    enum Directory {
        // Only documents and other data that is user-generated, or that cannot otherwise be recreated by your application, should be stored in the <Application_Home>/Documents directory and will be automatically backed up by iCloud.
        case documents
        
        // Data that can be downloaded again or regenerated should be stored in the <Application_Home>/Library/Caches directory. Examples of files you should put in the Caches directory include database cache files and downloadable content, such as that used by magazine, newspaper, and map applications.
        case caches
    }
    
    enum fileExtensions: String {
        case json
        case text = "txt"
    }
    
    enum PawStorageFile {
        
        case userDetail(String)
        case customerDetail(String)
        case productList
        case orderList(String)
        case filterList
        
        var fileExtension : fileExtensions {
            return .json
        }
        
        var prefix: String {
            return rawValue
        }
        
        var rawValue: String {
            switch self {
            case .userDetail(let value):
                return "userDetail_\(value)"
            case .customerDetail(let value):
                return "customerDetail_\(value)"
            case .productList:
                return "productList"
            case .orderList(let value):
                return "orderList_\(value)"
            case .filterList:
                return "filterList"
            }
        }
    }
}
