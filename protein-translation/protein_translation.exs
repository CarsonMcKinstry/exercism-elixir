defmodule ProteinTranslation do
  @codons %{
    :UGU => "Cysteine",
    :UGC => "Cysteine",
    :UUA => "Leucine",
    :UUG => "Leucine",
    :AUG => "Methionine",
    :UUU => "Phenylalanine",
    :UUC => "Phenylalanine",
    :UCU => "Serine",
    :UCC => "Serine",
    :UCA => "Serine",
    :UCG => "Serine",
    :UGG => "Tryptophan",
    :UAU => "Tyrosine",
    :UAC => "Tyrosine",
    :UAA => "STOP",
    :UAG => "STOP",
    :UGA => "STOP"
  }

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    rna_bundles = for <<codon::binary-3 <- rna>>, do: codon
    case Enum.flat_map_reduce(rna_bundles, [], &map_codons/2 ) do
      {_, ["invalid RNA"]} -> {:error, "invalid RNA"}
      {protein_list, _} -> {:ok, protein_list}
    end
  end

  def map_codons(codon, acc) do
    case of_codon(codon) do
      {:ok, "STOP"} -> {:halt, acc}
      {:ok, protein} -> {[protein], acc}
      {:error, _} -> {:halt, ["invalid RNA"]}
    end
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do 
    case Map.fetch(@codons, String.to_atom(codon)) do
      {:ok, protein} -> {:ok, protein}
      :error -> {:error, "invalid codon"}
    end
  end
end
