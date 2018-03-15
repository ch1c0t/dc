require 'hobby'

class Root
  include Hobby

  get { 'Some string from second app.' }
end
