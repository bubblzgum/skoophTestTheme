import { apiInitializer } from "discourse/lib/api";
import RouteFilterDropdown from "../components/route-filter-dropdown";

export default apiInitializer("1.8.0", (api) => {
  // Render the route filter dropdown after the navigation items
  api.renderInOutlet("after-category-navigation", RouteFilterDropdown);
});
