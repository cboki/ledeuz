require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit "/"
    assert_selector "h2", text: "Prochaines parties"
  end

  test "visiting the index as a logged in user" do
    login_as users(:sophie)
    visit "/"
    assert_selector "h2", text: "Prochaines parties"
  end

  test "lets an admin create a new game session" do
    login_as users(:clement)
    visit "/games/new"
    # save_and_open_screenshot

    select_date Date.new(2021,8,15), :from => 'Start datetime'
    click_on "Créer la partie"

    #should be redirected to Home with new session
    assert_equal root_path, page.current_path
    assert_text "2021-08-15"
  end
end
