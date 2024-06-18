// https://codepen.io/smargh/pen/gKdyQj
// via https://x.com/fractaledmind/status/1801191790827196652

import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static get targets() {
    return ["range", "value", "rangeFrom", "rangeTo", "valueFrom", "valueTo"];
  }

  connect() {
    if (this.hasValueTarget) {
      this.valueTarget.innerHTML = this.rangeTarget.value;
    }
    if (this.hasValueToTarget) {
      this.valueToTarget.innerHTML = this.rangeToTarget.value;
    }
    if (this.hasValueFromTarget) {
      this.valueFromTarget.innerHTML = this.rangeFromTarget.value;
    }
  }

  updateValue(evt) {
    this.valueTarget.innerHTML = evt.currentTarget.value;
  }

  updateFromValue() {
    let fromValue = this.rangeFromTarget.value;
    let toValue = this.rangeToTarget.value;

    if (fromValue >= toValue) {
      this.rangeToTarget.value = fromValue;
      this.valueToTarget.innerHTML = fromValue;
    }

    this.valueFromTarget.innerHTML = fromValue;
  }

  updateToValue() {
    let fromValue = this.rangeFromTarget.value;
    let toValue = this.rangeToTarget.value;

    if (toValue <= fromValue) {
      this.rangeFromTarget.value = toValue;
      this.valueFromTarget.innerHTML = toValue;
    }
    this.valueToTarget.innerHTML = toValue;
  }
}
