require 'minitest/autorun'
require_relative 'book_store'

# Common test data version: 1.4.0 33c6b60
class BookStoreTest < Minitest::Test
  def test_only_a_single_book
    # skip
    basket = [1]
    assert_equal 8.00, BookStore.calculate_price(basket)
  end

  def test_two_of_the_same_book
    # skip
    basket = [2, 2]
    assert_equal 16.00, BookStore.calculate_price(basket)
  end

  def test_empty_basket
    # skip
    basket = []
    assert_equal 0.00, BookStore.calculate_price(basket)
  end

  def test_two_different_books
    # skip
    basket = [1, 2]
    assert_equal 15.20, BookStore.calculate_price(basket)
  end

  def test_three_different_books
    # skip
    basket = [1, 2, 3]
    assert_equal 21.60, BookStore.calculate_price(basket)
  end

  def test_four_different_books
    # skip
    basket = [1, 2, 3, 4]
    assert_equal 25.60, BookStore.calculate_price(basket)
  end

  def test_five_different_books
    # skip
    basket = [1, 2, 3, 4, 5]
    assert_equal 30.00, BookStore.calculate_price(basket)
  end

  def test_two_groups_of_four_is_cheaper_than_group_of_five_plus_group_of_three
    # skip
    basket = [1, 1, 2, 2, 3, 3, 4, 5]
    assert_equal 51.20, BookStore.calculate_price(basket)
  end

  def test_two_groups_of_four_is_cheaper_than_groups_of_five_and_three
    # skip
    basket = [1, 1, 2, 3, 4, 4, 5, 5]
    assert_equal 51.20, BookStore.calculate_price(basket)
  end

  def test_group_of_four_plus_group_of_two_is_cheaper_than_two_groups_of_three
    # skip
    basket = [1, 1, 2, 2, 3, 4]
    assert_equal 40.80, BookStore.calculate_price(basket)
  end

  def test_two_each_of_first_4_books_and_1_copy_each_of_rest
    # skip
    basket = [1, 1, 2, 2, 3, 3, 4, 4, 5]
    assert_equal 55.60, BookStore.calculate_price(basket)
  end

  def test_two_copies_of_each_book
    # skip
    basket = [1, 1, 2, 2, 3, 3, 4, 4, 5, 5]
    assert_equal 60.00, BookStore.calculate_price(basket)
  end

  def test_three_copies_of_first_book_and_2_each_of_remaining
    # skip
    basket = [1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 1]
    assert_equal 68.00, BookStore.calculate_price(basket)
  end

  def test_three_each_of_first_2_books_and_2_each_of_remaining_books
    # skip
    basket = [2, 1, 2, 2, 3, 3, 4, 4, 5, 5, 1, 1]
    # with_hist do
      assert_equal 75.20, BookStore.calculate_price(basket)
    # end
  end

  def test_four_groups_of_four_are_cheaper_than_two_groups_each_of_five_and_three
    # skip
    basket = [1, 1, 2, 2, 3, 3, 4, 5, 1, 1, 2, 2, 3, 3, 4, 5]
    # with_hist do
      assert_equal 102.40, BookStore.calculate_price(basket)
    # end
  end

  def with_hist
    setup_hist
    yield
    print_hist
  end

  def setup_hist
    $hist = Hash.new do |h, k|
      h[k] = { call: 0, cache_fetch: 0 }
    end
  end

  def print_hist
    puts('%-5s%-7s%s' % ['call', 'cache', 'combo'])
    puts '-----------------------------------'
    perfect = true
    $hist.to_a.sort_by { |_, data| data[:call] }.each do |combo, data|
      perfect &&= data[:call] - data[:cache_fetch] == 1
      puts('%-5s%-7s%s' % [data[:call], data[:cache_fetch], combo])
    end
    puts ''
    perfect ? puts("PERFECT CACHE! :)") : puts("IMPERFECT CACHE! :(")
  end
end
