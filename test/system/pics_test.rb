require "application_system_test_case"

class PicsTest < ApplicationSystemTestCase
  setup do
    @pic = pics(:one)
  end

  test "visiting the index" do
    visit pics_url
    assert_selector "h1", text: "Pics"
  end

  test "creating a Pic" do
    visit pics_url
    click_on "New Pic"

    fill_in "Body", with: @pic.body
    fill_in "Image1", with: @pic.image1
    fill_in "Image2", with: @pic.image2
    fill_in "Image3", with: @pic.image3
    fill_in "Image4", with: @pic.image4
    fill_in "Image5", with: @pic.image5
    click_on "Create Pic"

    assert_text "Pic was successfully created"
    click_on "Back"
  end

  test "updating a Pic" do
    visit pics_url
    click_on "Edit", match: :first

    fill_in "Body", with: @pic.body
    fill_in "Image1", with: @pic.image1
    fill_in "Image2", with: @pic.image2
    fill_in "Image3", with: @pic.image3
    fill_in "Image4", with: @pic.image4
    fill_in "Image5", with: @pic.image5
    click_on "Update Pic"

    assert_text "Pic was successfully updated"
    click_on "Back"
  end

  test "destroying a Pic" do
    visit pics_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Pic was successfully destroyed"
  end
end
