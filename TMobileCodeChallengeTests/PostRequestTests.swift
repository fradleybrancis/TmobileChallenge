
import XCTest
@testable import TMobileCodeChallenge

class PostRequestTests: XCTestCase {
    
    var sut: FeedRequest?
    
    override func setUp() {
        super.setUp()
        sut = FeedRequest(pagination: false)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_DataTaskCompletesWithStatusCode200() {
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        let dataTask = URLSession.shared.dataTask(with: sut!.resourceURL) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
        
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    func test_DownloadArrayOfPosts() {
        let promise = expectation(description: "Posts contain 25 items")
        var posts: [Post] = []
        var responseError: Error?
        sut?.getPosts { result in
            switch result {
            case .failure(let error):
                responseError = error
            case .success(let downloadedPosts):
                posts = downloadedPosts
                promise.fulfill()

            }
        }
        wait(for: [promise], timeout: 5)
        XCTAssertNil(responseError)
        XCTAssertEqual(posts.count, 25)
    }

    func test_GetPostsReturnPostsWithScore() {
        let promise = expectation(description: "Post has score that is not nil")
        var posts: [Post] = []
        var responseError: Error?
        sut?.getPosts { result in
            switch result {
            case .failure(let error):
                responseError = error
            case .success(let downloadedPosts):
                posts = downloadedPosts
                promise.fulfill()

            }
        }
        wait(for: [promise], timeout: 5)
        XCTAssertNil(responseError)
        XCTAssertNotNil(posts.first?.data.score)
    }

    
    
}
