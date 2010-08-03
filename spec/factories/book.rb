Factory.define :category do |f|
  f.sequence(:name) { |n| "Category #{n}" }
end

Factory.define :license do |f|
  f.sequence(:url) { |n| "http://example.com/license/#{n}" }
end

Factory.define :book do |f|
  f.user { User.create(Factory.attributes_for(:user)) }
  f.sequence(:title) { |n| "Book Title #{n}" }
  f.category { Category.create(Factory.attributes_for(:category)) }
  f.reward '50'
  f.license { License.create(Factory.attributes_for(:license)) }
  f.terms 'on any terms'
end

Factory.define :chapter do |f|
  f.parent { Book.create(Factory.attributes_for(:book)) }
  f.sequence(:title) { |n| "Chapter Title #{n}" }
  f.content 'some content'
end

Factory.define :sub_chapter do |f|
  f.parent { Chapter.create(Factory.attributes_for(:chapter)) }
  f.sequence(:title) { |n| "Sub-Chapter Title #{n}" }
  f.content 'some sub-chapter content'
end

Factory.define :notification do |f|
  f.user { User.create(Factory.attributes_for(:user)) }
  f.book { Book.create(Factory.attributes_for(:book)) }
end

Factory.define :comment do |f|
  f.user { User.create(Factory.attributes_for(:user)) }
  f.commentable { Book.create(Factory.attributes_for(:book)) }
  f.content 'some comment content'
end

