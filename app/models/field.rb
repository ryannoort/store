class Field < ApplicationRecord
	belongs_to :form
end

class TextField < Field
end

class TextArea < Field
end

class Image < Field
end

class Email < Field
end

class Url < Field
end

