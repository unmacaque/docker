import io.gatling.core.Predef._
import io.gatling.http.Predef._
import scala.concurrent.duration._

class TestSimulation extends Simulation {

  val httpProtocol = http
    .baseUrl("http://localhost:8080")
    .acceptHeader("text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8")
    .doNotTrackHeader("1")
    .acceptLanguageHeader("en-US,en;q=0.5")
    .acceptEncodingHeader("gzip, deflate")
    .userAgentHeader("Mozilla/5.0 (Windows NT 5.1; rv:31.0) Gecko/20100101 Firefox/31.0")

  val scn = scenario("TestSimulation")
    .exec(http("request_1")
      .get("/")
      .check(status.is(200)))

  setUp(
    scn.inject(rampUsers(10).during(10.seconds))
  ).protocols(httpProtocol)
}
