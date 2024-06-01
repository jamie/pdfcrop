import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["label", "range"];

  update() {
    let value = Number(this.rangeTarget.value);
    this.labelTarget.textContent = value;

    let imgs = document.getElementById("pageGrid").children;
    for (let i = 0; i < imgs.length; i++) {
      imgs[i].classList.remove("ignored");
    }
    for (let i = 0; i < value; i++) {
      imgs[i].classList.add("ignored");
    }
  }
}
