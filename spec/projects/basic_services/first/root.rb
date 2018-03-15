require 'hobby'

class Root
  include Hobby

  get { 'Some string from first app.' }
end
