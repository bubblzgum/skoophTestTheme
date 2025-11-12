import { apiInitializer } from "discourse/lib/api";
import TopicNavigationFilter from "../components/topic-navigation-filter";

export default apiInitializer("1.8.0", (api) => {
  // Add the filter dropdown to the navigation container
  // Using the after-topic-navigation outlet which appears in the navigation area
  api.renderInOutlet("after-topic-navigation", TopicNavigationFilter);
});
