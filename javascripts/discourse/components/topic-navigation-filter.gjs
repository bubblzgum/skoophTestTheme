import Component from "@glimmer/component";
import { service } from "@ember/service";
import { action } from "@ember/object";
import DButton from "discourse/components/d-button";
import DropdownSelectBox from "select-kit/components/dropdown-select-box";

export default class TopicNavigationFilter extends Component {
  @service router;

  get filterOptions() {
    return [
      {
        id: "latest",
        name: "Latest",
        icon: "clock",
      },
      {
        id: "top",
        name: "Top",
        icon: "signal",
      },
      {
        id: "hot",
        name: "Hot",
        icon: "fire",
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
    const categorySlug = this.router.currentRoute?.params?.category_slug_path_with_id;
    const tagId = this.router.currentRoute?.params?.tag_id;
    
    let route;
    if (categorySlug) {
      route = `discovery.${filterId}Category`;
    } else if (tagId) {
      route = `tag.show${filterId === "latest" ? "" : `.${filterId}`}`;
    } else {
      route = `discovery.${filterId}`;
    }
    
    this.router.transitionTo(route);
  }

  <template>
    <div class="topic-navigation-filter">
      <DropdownSelectBox
        @content={{this.filterOptions}}
        @value={{this.selectedFilter}}
        @onChange={{this.onFilterChange}}
        @options={{hash icon="filter" showFullTitle=true}}
        class="topic-filter-dropdown"
      />
    </div>
  </template>
}
