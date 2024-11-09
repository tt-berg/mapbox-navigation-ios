import Combine
import CoreLocation
import MapboxCommon
import MapboxDirections
@testable import MapboxNavigationCore
import XCTest

open class TestCase: XCTestCase {
    public var billingServiceMock: BillingServiceMock!
    public var coreConfig: CoreConfig!
    public var locationPublisher: CurrentValueSubject<CLLocation, Never>!

    @MainActor
    override open func setUp() {
        super.setUp()
        Credentials.injectSharedToken()

        billingServiceMock = .init()
        let billingHandler = BillingHandler.__createMockedHandler(with: billingServiceMock)
        let credentials = NavigationCoreApiConfiguration(accessToken: .mockedAccessToken)
        coreConfig = CoreConfig(credentials: credentials)
        coreConfig.__customBillingHandler = BillingHandlerProvider(billingHandler)
        let location = CLLocation(latitude: 9.519172, longitude: 47.210823)
        locationPublisher = .init(location)
    }

    override open func tearDown() {
        Credentials.clearInjectSharedToken()
        super.tearDown()
    }
}
