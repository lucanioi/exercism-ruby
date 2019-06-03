module Dominoes
  module_function

  def chain?(dominoes, chain = [])
    return loop?(chain) if dominoes.empty?
    dominoes.each_with_index do |domino, i|
      next unless new_chain = connect(chain, domino)
      return true if chain?(rest(dominoes, i), new_chain)
    end
    false
  end

  def loop?(chain)
    chain.first&.dig(0) == chain.last&.dig(1)
  end

  def connect(chain, domino)
    case chain.last&.dig(1)
    when nil, domino[0] then chain + [domino]
    when domino[1] then chain + [domino.reverse]
    end
  end

  def rest(dominoes, i)
    dominoes[0...i] + dominoes[i + 1...dominoes.size]
  end
end
