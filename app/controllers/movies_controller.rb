class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    # Recuperamos el orden de filtrado por columna (filas o fecha)
    orden_filtrado_columnas = params[:ordenacion_seleccionada]
    
    if orden_filtrado_columnas == 'porTitulo'
      # Ordenacion por TITLE
      @movies = Movie.order('title ASC')
      
      # Modificación del estilo de la cabecera
      @clase_cabecera_titulo = 'hilite'
    elsif orden_filtrado_columnas == 'porFecha'
      # Ordenación por RELEASE_DATE
      @movies = Movie.order('release_date ASC')
      
      # Modificación del estilo de la cabecera
      @clase_cabecera_fecha = 'hilite'
    else
      @movies = Movie.all
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
