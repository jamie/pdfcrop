require "application_system_test_case"

class PdfsTest < ApplicationSystemTestCase
  setup do
    @pdf = pdfs(:one)
  end

  test "visiting the index" do
    visit pdfs_url
    assert_selector "h1", text: "Pdfs"
  end

  test "should create pdf" do
    visit pdfs_url
    click_on "New pdf"

    click_on "Create Pdf"

    assert_text "Pdf was successfully created"
    click_on "Back"
  end

  test "should update Pdf" do
    visit pdf_url(@pdf)
    click_on "Edit this pdf", match: :first

    click_on "Update Pdf"

    assert_text "Pdf was successfully updated"
    click_on "Back"
  end

  test "should destroy Pdf" do
    visit pdf_url(@pdf)
    click_on "Destroy this pdf", match: :first

    assert_text "Pdf was successfully destroyed"
  end
end
