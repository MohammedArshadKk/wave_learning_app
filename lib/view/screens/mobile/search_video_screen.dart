import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave_learning_app/view/screens/mobile/search_results_videos_screen.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/custom_text.dart';
import 'package:wave_learning_app/view/utils/custom_widgets/no_data_widget.dart';
import 'package:wave_learning_app/view/utils/images_fonts.dart';
import 'package:wave_learning_app/view_model/cubits/search_videos_cubit/search_videos_cubit.dart';

class SearchVideoScreen extends StatelessWidget {
  SearchVideoScreen({super.key});
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 600;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: CustomText(
          text: 'Search Videos',
          color: Colors.black87,
          fontSize: isSmallScreen ? 18 : 24,
          fontFamily: Fonts.primaryText,
          fontWeight: FontWeight.normal,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
        child: Column(
          children: [
            _buildSearchBar(context, isSmallScreen),
            Expanded(
              child: BlocBuilder<SearchVideosCubit, SearchVideosState>(
                builder: (context, state) {
                  if (state is SearchState) {
                    if (state.isLoading) {
                      return _buildLoadingIndicator();
                    } else if (state.suggestions.isEmpty) {
                      return _buildEmptyState(
                          'No results found', isSmallScreen);
                    } else {
                      return _buildSuggestionsList(
                          state.suggestions, isSmallScreen);
                    }
                  } else {
                    return _buildEmptyState('Search for videos', isSmallScreen);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, bool isSmallScreen) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: isSmallScreen ? 8.0 : 16.0),
      child: TextField(
        onChanged: (query) {
          context.read<SearchVideosCubit>().debounceSearch(query.toLowerCase());
        },
        controller: searchController,
        style: TextStyle(fontSize: isSmallScreen ? 14 : 16),
        decoration: InputDecoration(
          hintText: 'Search...',
          hintStyle: TextStyle(
              color: Colors.grey[400], fontSize: isSmallScreen ? 14 : 16),
          suffixIcon: IconButton(
            onPressed: () {
              if (searchController.text.isNotEmpty) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => BlocProvider(
                    create: (context) => SearchVideosCubit(),
                    child: SearchResultsVideosScreen(
                        text: searchController.text.toLowerCase()),
                  ),
                ));
              }
            },
            icon: Icon(Icons.search, size: isSmallScreen ? 20 : 24),
          ),
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(isSmallScreen ? 6 : 8),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 12 : 16,
            vertical: isSmallScreen ? 8 : 12,
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildEmptyState(String message, bool isSmallScreen) {
    return SingleChildScrollView(
      child: Center(
        child: NoDataWidget(
          text: message,
        ),
      ),
    );
  }

  Widget _buildSuggestionsList(List<String> suggestions, bool isSmallScreen) {
    return ListView.separated(
      itemCount: suggestions.length,
      separatorBuilder: (context, index) =>
          Divider(height: 1, color: Colors.grey[200]),
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 8 : 16,
            vertical: isSmallScreen ? 4 : 8,
          ),
          title: CustomText(
            text: suggestions[index],
            color: Colors.black87,
            fontSize: isSmallScreen ? 14 : 16,
            fontFamily: Fonts.primaryText,
            fontWeight: FontWeight.normal,
          ),
          trailing: Icon(Icons.north_west,
              color: Colors.grey[400], size: isSmallScreen ? 16 : 18),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => BlocProvider(
                create: (context) => SearchVideosCubit(),
                child: SearchResultsVideosScreen(text: suggestions[index]),
              ),
            ));
          },
        );
      },
    );
  }
}
