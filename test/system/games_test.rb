require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "visiting the root page as a visitor" do
    visit "/"
    assert_selector "h2", text: "Prochaines parties".upcase
  end

  test "visiting the root page as a user" do
    login_as users(:sophie)
    visit "/"
    assert_selector "h2", text: "Prochaines parties".upcase
  end

  test "visiting the root page as an admin" do
    login_as users(:clement)
    visit "/"
    assert_selector "h2", text: "Prochaines parties".upcase
  end

  test "lets an admin create a new game session" do
    login_as users(:clement)
    visit "/games/new"

    select_date Date.new(2021,8,15), :from => 'Start datetime'
    click_on "Créer la partie"

    #should be redirected to Home with new session
    assert_equal root_path, page.current_path
    assert_text "15 août 2021"
  end

  test "an user cannot access /games/new page" do
    login_as users(:sophie)
    visit "/games/new"
    assert_text 'Error'
  end

  test "a visitor cannot access /games/new page" do
    visit "/games/new"
    assert_text 'Connexion'.upcase
  end

  test "a user can access show page of a game session" do
    login_as users(:sophie)
    visit "/games/1"
    #save_and_open_screenshot
    assert_text "14 juillet 2021"
  end
end
