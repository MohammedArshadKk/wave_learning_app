import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view/screens/mobile/search_results_videos_screen.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/no_data_widget.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';
import 'package:wave_learning_app/view_model/cubits/search_videos_cubit/search_videos_cubit.dart';

class SearchVideoScreen extends StatelessWidget {
   SearchVideoScreen({super.key});
final TextEditingController searchController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: CustomText(
          text: 'Search Videos',
          color: Colors.black87,
          fontSize: 20,
          fontFamily: Fonts.labelText,
          fontWeight: FontWeight.normal,
        ),
      ),
      body: Column(
        children: [
          _buildSearchBar(context),
          Expanded(
            child: BlocBuilder<SearchVideosCubit, SearchVideosState>(
              builder: (context, state) {
                if (state is SearchState) {
                  if (state.isLoading) {
                    return _buildLoadingIndicator();
                  } else if (state.suggestions.isEmpty) {
                    return _buildEmptyState('No results found');
                  } else {
                    return _buildSuggestionsList(state.suggestions);
                  }
                } else {
                  return _buildEmptyState('Search for videos');
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        onChanged: (query) {
          context.read<SearchVideosCubit>().searchVideo(query);
        },
        controller:searchController , 
        decoration: InputDecoration(
          hintText: 'Search...',
          hintStyle: TextStyle(color: Colors.grey[400]),  
          suffixIcon: IconButton(onPressed: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (ctx) => BlocProvider(
                      create: (context) => SearchVideosCubit(),
                      child:  SearchResultsVideosScreen(text: searchController.text,), 
                    )));
          }, icon: Icon(Icons.search)),
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildEmptyState(String message) {
    return SingleChildScrollView(child: NoDataWidget(text: message));
  }

  Widget _buildSuggestionsList(List<String> suggestions) {
    return ListView.separated(
      itemCount: suggestions.length,
      separatorBuilder: (context, index) =>
          Divider(height: 1, color: Colors.grey[200]),
      itemBuilder: (context, index) {
        return ListTile(
          title: CustomText(
            text: suggestions[index],
            color: Colors.black87,
            fontSize: 16,
            fontFamily: Fonts.labelText,
            fontWeight: FontWeight.normal,
          ),
          trailing: Icon(Icons.north_west, color: Colors.grey[400], size: 18),
          onTap: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (ctx) => BlocProvider(
                      create: (context) => SearchVideosCubit(),
                      child:  SearchResultsVideosScreen(text:suggestions[index] ,), 
                    )));
          },
        );
      },
    );
  }
}
