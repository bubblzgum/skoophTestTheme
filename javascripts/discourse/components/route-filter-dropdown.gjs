import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { action } from "@ember/object";
import { service } from "@ember/service";
import ComboBox from "select-kit/components/combo-box";

export default class RouteFilterDropdown extends Component {
  @service router;
  @tracked selectedRoute = "latest";

  get routeOptions() {
    return [
      {
        id: "latest",
        name: "Latest",
        icon: "clock",
      },
      {
        id: "hot",
        name: "Hot",
        icon: "fire",
      },
      {
        id: "top",
        name: "Top",
        icon: "signal",
      },
    ];
  }

  get content() {
    return this.routeOptions;
  }

  get value() {
    const currentRoute = this.router.currentRouteName;
    if (currentRoute?.includes("hot")) {
      return "hot";
    } else if (currentRoute?.includes("top")) {
      return "top";
    }
    return "latest";
  }

  @action
  onChange(routeId) {
    this.selectedRoute = routeId;
    
    // Navigate to the selected route
    const category = this.router.currentRoute?.attributes?.category;
    const tag = this.router.currentRoute?.attributes?.tag;
    
    if (category) {
      const categorySlug = category.slug || category;
      this.router.transitionTo(`discovery.${routeId}Category`, categorySlug);
    } else if (tag) {
      const tagId = tag.id || tag;
      const routeName = routeId === "latest" ? "latest" : routeId.charAt(0).toUpperCase() + routeId.slice(1);
      this.router.transitionTo(`tags.show${routeName}`, tagId);
    } else {
      this.router.transitionTo(`discovery.${routeId}`);
    }
  }

  <template>
    <div class="route-filter-dropdown">
      <ComboBox
        @content={{this.content}}
        @value={{this.value}}
        @onChange={{this.onChange}}
        @nameProperty="name"
        @valueProperty="id"
        class="route-filter-combo"
      />
    </div>
  </template>
}
