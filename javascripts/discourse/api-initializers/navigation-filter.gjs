import { apiInitializer } from "discourse/lib/api";
import TopicNavigationFilter from "../components/topic-navigation-filter";

export default apiInitializer("1.8.0", (api) => {
  api.renderInOutlet("navigation-container", TopicNavigationFilter);
});
