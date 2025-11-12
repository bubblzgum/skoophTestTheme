import Component from "@glimmer/component";
import { service } from "@ember/service";
import { action } from "@ember/object";
import DropdownSelectBox from "select-kit/components/dropdown-select-box";

export default class TopicNavigationFilter extends Component {
  @service router;

  get filterOptions() {
    return [
      {
        id: "latest",
        name: "Latest",
        description: "Most recent topics",
      },
      {
        id: "top",
        name: "Top",
        description: "Most popular topics",
      },
      {
        id: "hot",
        name: "Hot",
        description: "Trending topics",
      },
    ];
  }

  get selectedFilter() {
    const routeName = this.router.currentRouteName;
    if (routeName.includes("top")) {
      return "top";
    } else if (routeName.includes("hot")) {
      return "hot";
    }
    return "latest";
  }

  @action
  onFilterChange(filterId) {
    if (filterId === this.selectedFilter) {
      return;
    }

    try {
      const params = this.router.currentRoute?.params || {};
      const categorySlug = params.category_slug_path_with_id;
      const tagId = params.tag_id;
      
      let route;
      if (categorySlug) {
        // Category route
        if (filterId === "latest") {
          route = "discovery.category";
        } else {
          route = `discovery.${filterId}Category`;
        }
        this.router.transitionTo(route, categorySlug);
      } else if (tagId) {
        // Tag route
        if (filterId === "latest") {
          route = "tag.show";
        } else {
          route = `tag.show${filterId.charAt(0).toUpperCase() + filterId.slice(1)}`;
        }
        this.router.transitionTo(route, tagId);
      } else {
        // General route
        this.router.transitionTo(`discovery.${filterId}`);
      }
    } catch (e) {
      console.error("Navigation error:", e);
      // Fallback to simple route
      this.router.transitionTo(`discovery.${filterId}`);
    }
  }

  <template>
    <div class="topic-navigation-filter">
      <DropdownSelectBox
        @content={{this.filterOptions}}
        @value={{this.selectedFilter}}
        @onChange={{this.onFilterChange}}
        @options={{hash icon=null showFullTitle=true}}
        class="topic-filter-dropdown"
      />
    </div>
  </template>
}
